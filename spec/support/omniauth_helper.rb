# [参考]https://github.com/yukihirop/GrapeSlack/blob/master/spec/support/omniauth_helper.rb
# spec/support/omniauth_helper.rb
module OmniauthHelpers
  def set_slack_omniauth
    OmniAuth.config.mock_auth[:slack] =
        OmniAuth::AuthHash.new(
            {
                'provider'  => 'slack',
                'uid'       => 'mock_uid_1234',
                },
        )
  end

  def set_user_info
    user_info = {
      "user"=>
        {"name"=>'sample_name',
        "email"=>Faker::Internet.email,
        "image_192"=>ENV['USER_IMAGE'],},
      "team"=>
        {"id"=>ENV['TEAM_ID'],
        "name"=>"show_profile_development",
        "image_230"=>ENV['TEAM_IMAGE'],
        }
    }
    user_info
  end

  def set_invalid_omniauth
    OmniAuth.config.mock_auth[:slack] = :invalid_credentials
  end
end