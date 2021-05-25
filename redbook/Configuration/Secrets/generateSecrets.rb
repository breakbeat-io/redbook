require 'openssl'
require 'base64'
require 'jwt'
require 'erb'

# Make sure the correct ENV is available, else abort.
abort('Cannot generate Secrets - missing APP_STORE_CONNECT_TEAM_ID') if ENV['APP_STORE_CONNECT_TEAM_ID'].nil?
abort('Cannot generate Secrets - missing APPLE_MUSIC_KEY_ID') if ENV['APPLE_MUSIC_KEY_ID'].nil?
abort('Cannot generate Secrets - missing APPLE_MUSIC_PRIVATE_KEY') if ENV['APPLE_MUSIC_PRIVATE_KEY'].nil?

# Generate the Apple Music API JWT
payload = {
  iss: ENV['APP_STORE_CONNECT_TEAM_ID'],
  iat: Time.now.to_i,
  exp: Time.now.to_i + 15000000 # exp can be no longer than 6 months, this is slightly short to avoid server time differences
}

header = {
  kid: ENV['APPLE_MUSIC_KEY_ID']
}

key = OpenSSL::PKey::EC.new(Base64.decode64(ENV['APPLE_MUSIC_PRIVATE_KEY']))

algorithm = 'ES256'

apple_music_api_jwt = JWT.encode(payload, key, algorithm, header)

# Create the Secrets.swift to make the secrets available

secrets_swift_template = <<-SECRETS_STRUCT
// autogenerated on build, do not edit
struct Secrets {
  static let appleMusicAPIToken = "<%= apple_music_api_jwt %>"
}
SECRETS_STRUCT

File.open(File.join(__dir__, 'Secrets.swift'), 'w') do |f|
  f.write ERB.new(secrets_swift_template).result()
end