# Finished in 1 minute 45.06 seconds (files took 5.08 seconds to load)
# 12 examples, 0 failures
require 'rails_helper'

RSpec.describe 'TextBlock', type: :system do

  let(:text_block) { TextBlock.last }
  let!(:factory_text_block) { create(:text_block) }

  let(:words_over_fifty)      { 'あ' * 51 }
  let(:words_over_two_hundreds) { 'あ' * 201 }

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.second }

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_top_path
    find('#profile-edit-button').click
  end

  describe 'テキストブロック作成機能' do
    context '正常な値を入力した時' do
      before do
        click_on 'テキストブロックを追加する'
        sleep 1
        expect(page).to have_button 'テキストブロックを作成！', disabled: true
        fill_in 'text_block_title',	with: factory_text_block.title
        fill_in 'text_block_text',	with: factory_text_block.text
        expect(page).to have_button 'テキストブロックを作成！', disabled: false
        click_on 'テキストブロックを作成！'
        page.driver.browser.switch_to.alert.dismiss
      end
      it 'テキストブロックが作成されること' do
        expect(page).to have_content(factory_text_block.title), 'テキストブロックが作成されていません'
        expect(page).to have_content(factory_text_block.text),  'テキストブロックが作成されていません'
        expect(page).to have_content('テキストブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
      end

      it '作成したブロックが詳細ページに反映されていること' do
        visit "/profiles/#{my_profile.public_uid}"
        sleep 1
        expect(page).to have_content(factory_text_block.title), 'テキストブロックが作成されていません'
        expect(page).to have_content(factory_text_block.text),  'テキストブロックが作成されていません'
      end

      it '作成したブロックが他人の詳細ページに反映されていないこと' do
        visit "/profiles/#{others_profile.public_uid}"
        sleep 1
        expect(page).not_to have_content(factory_text_block.title)
        expect(page).not_to have_content(factory_text_block.text)
      end

      it '作成ボタンがdisableに戻っていること' do
        click_on 'テキストブロックを追加する'
        expect(page).to have_button 'テキストブロックを作成！', disabled: true
      end
    end

    context 'タイトルが未入力の時' do
      before do
        click_on 'テキストブロックを追加する'
        fill_in 'text_block_title',	with: ''
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'テキストブロックを作成！', disabled: true
      end
    end

    context 'タイトルが51文字以上の時' do
      before do
        click_on 'テキストブロックを追加する'
        fill_in 'text_block_title',	with: words_over_fifty
        sleep 0.5
        fill_in 'text_block_title',	with: words_over_fifty
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'テキストブロックを作成！', disabled: true
      end
    end

    context 'テキストが201文字以上の時' do
      before do
        click_on 'テキストブロックを追加する'
        fill_in 'text_block_text', with: words_over_two_hundreds
        sleep 0.5
        fill_in 'text_block_text', with: words_over_two_hundreds
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('テキストは最大200文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'テキストブロックを作成！', disabled: true
      end
    end
  end

  describe 'テキストブロック編集機能' do
    before do
      click_on 'テキストブロックを追加する'
      expect(page).to have_button 'テキストブロックを作成！', disabled: true
      fill_in 'text_block_title',	with: 'タイトル'
      fill_in 'text_block_text', with: 'テキスト'
      expect(page).to have_button 'テキストブロックを作成！', disabled: false
      click_on 'テキストブロックを作成！'
      page.driver.browser.switch_to.alert.dismiss
    end
    context 'テキストブロックを更新した時' do
      before do
        sleep 1
        find("#edit-text-block-button-#{text_block.id}").click
        expect(page).to have_content('テキストブロックを編集'), 'テキストブロック編集ダイアログが表示されていません'
        fill_in 'text_block_title',	with: '編集されたタイトル'
        fill_in 'text_block_text', with: '編集されたテキスト'
        expect(page).to have_button 'テキストブロックを更新！', disabled: false
        click_on 'テキストブロックを更新！'
      end
      it 'テキストブロックの値が更新されていること' do
        expect(page).to have_content('編集されたタイトル'), 'タイトルが更新されていません'
        expect(page).to have_content('編集されたテキスト'), 'テキストが更新されていません'
        expect(page).to have_content('テキストブロックを更新したよ！'), 'フラッシュメッセージが表示されていません'
      end

      it '作成したブロックが詳細ページに反映されていること' do
        visit "/profiles/#{my_profile.public_uid}"
        sleep 1
        expect(page).to have_content('編集されたタイトル'), 'タイトルが更新されていません'
        expect(page).to have_content('編集されたテキスト'), 'テキストが更新されていません'
      end
    end
  end

  describe 'テキストブロック削除機能' do
    before do
      click_on 'テキストブロックを追加する'
      expect(page).to have_button 'テキストブロックを作成！', disabled: true
      fill_in 'text_block_title',	with: '削除されるテキストブロック'
      fill_in 'text_block_text',	with: '削除されるテキストブロック'
      expect(page).to have_button 'テキストブロックを作成！', disabled: false
      click_on 'テキストブロックを作成！'
      page.driver.browser.switch_to.alert.dismiss
    end
    context '削除ボタンを押してconfirmダイアログで「OK」を選択した時' do
      before do
        sleep 1
        find("#delete-text-block-button-#{text_block.id}").click
        page.driver.browser.switch_to.alert.accept # confirmダイアログで「OK」を選択する
      end
      it '対象のテキストブロックが削除されること' do
        expect(page).not_to have_content('削除されるテキストブロック'), '対象のテキストブロックが削除されていません'
        expect(page).to have_content('テキストブロックを削除したよ！'), 'フラッシュメッセージが表示されていません'
      end

      it '詳細ページから対象のテキストブロックが削除されること' do
        visit "/profiles/#{my_profile.public_uid}"
        sleep 1
        expect(page).not_to have_content('削除されるテキストブロック'), '対象のテキストブロックが削除されていません'
      end
    end

    context '削除ボタンを押してconfirmダイアログで「キャンセル」を選択した時' do
      before do
        sleep 1
        find("#delete-text-block-button-#{text_block.id}").click
        page.driver.browser.switch_to.alert.dismiss # confirmダイアログで「キャンセル」を選択する
      end
      it '対象のテキストブロックが削除されないこと' do
        expect(page).to have_content('削除されるテキストブロック'), '対象のテキストブロックが削除されています'
        expect(page).not_to have_content('テキストブロックを削除したよ！'), 'フラッシュメッセージが表示されています'
      end
    end
  end
end
