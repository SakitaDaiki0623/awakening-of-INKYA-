module SlackApiActivatable

  def check_channel(info, access_token)
    uid = info.dig('user', 'id')
    channels = get_channel_list(access_token).dig("channels")
    channel_name = "プロフ共有スペース"
    channel = channels.select { |c| c.dig("name") == channel_name }[0]

    if channel.nil?
      created_channel = create_channel_in_team(channel_name, access_token).dig("channel")
      invite_result = try_invite_user(info, created_channel, access_token)
      post_direct_message_to_user(info, access_token)
    else
      invite_result = try_invite_user(info, channel, access_token)
      post_direct_message_to_user(info, access_token)
    end
  end

  # API Methods
  def get_user_info(user_token)
    user_token.get('/api/users.identity').parsed
  end

  def get_channel_list(access_token)
    access_token.get('/api/conversations.list').parsed
  end

  def create_channel_in_team(channel_name, access_token)
    encoded_name = URI.encode_www_form_component(channel_name)
    access_token.post("api/conversations.create?name=#{encoded_name}&pretty=1").parsed
  end

  def try_invite_user(info, channel, access_token)
    channel_id = channel.dig("id")
    user_id = info.dig("user", "id")
    access_token.post("api/conversations.invite?channel=#{channel_id}&users=#{user_id}&pretty=1").parsed
  end

  def post_direct_message_to_user(info, access_token)
    user_id = info.dig("user", "id")
    message = '{[{"type": "section", 	"text": { "type": "plain_text", "text": "プロフちゃんの世界へようこそ:musical_note:\n これからよろしくお願いします！", "emoji": true 	}}]}'
    encoded_message = URI.encode_www_form_component(message)
    text = "プロフちゃんの世界へようこそ"
    encoded_text = URI.encode_www_form_component(text)

    access_token.post("api/chat.postMessage?channel=#{user_id}&text=#{encoded_text}&pretty=1").parsed
  end
end