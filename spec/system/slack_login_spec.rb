# pass 3
# spec/system/slack_login_spec.rb
require 'rails_helper'

RSpec.describe "SlackLogin", type: :system do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # omniauth.authの値を代入
    allow_any_instance_of(Users::OmniauthCallbacksController).to receive(:get_user_info).and_return(set_user_info) # strategy.authの値を代入
  end

  context 'oauthがinvalid_omniauthの場合' do
    before do
      Rails.application.env_config["omniauth.auth"] = set_invalid_omniauth
      visit root_path
      find("#sign_in_with_slack_button").click
    end
    it "トップページにリダイレクトされること" do
      expect(current_path).to eq(root_path), 'ルートパスにリダイレクトされていません'
    end
  end

  context '初めてアプリにログインする時' do
    before do
      visit root_path
    end
    it 'プロフィール新規作成画面にアクセスすること' do
      expect{ find("#sign_in_with_slack_button").click }.to change(User, :count).by(1), 'ユーザー数が1人増えていません'
      expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
    end
  end

  context 'プロフィールを作成して再度ログインする時' do
    before do
      slack_login_first_time
      create_profile
      expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
      expect(page).to have_content('ログアウト'), 'ログアウトボタンが表示されていません'
      click_on 'ログアウト'
      expect(current_path).to eq(root_path), 'パスがroot_pathではありません'
      expect{ find("#sign_in_with_slack_button").click }.to change(User, :count).by(0), 'ユーザー数が1人増えています'
    end
    it 'プロフィール一覧画面にリダイレクトされること' do
      expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
    end
  end

end
