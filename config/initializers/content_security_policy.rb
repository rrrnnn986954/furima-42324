# frozen_string_literal: true
# Be sure to restart your server when you modify this file.

# Payjp + Rails CSP 設定
Rails.application.config.content_security_policy do |policy|
  # デフォルトは自己ドメイン + https
  policy.default_src :self, :https

  # スクリプト許可
  policy.script_src :self, :https, "https://js.pay.jp", -> { "'nonce-#{SecureRandom.base64(16)}'" }

  # iframe 許可（Payjp用）
  policy.frame_src :self, :https, "https://js.pay.jp"

  # スタイル許可
  policy.style_src :self, :https

  # 画像許可（必要に応じてS3 URL追加）
  policy.img_src :self, :https, "https://your-bucket.s3.amazonaws.com", "data:"

  # フォント許可
  policy.font_src :self, :https, "data:"

  # API 通信先
  policy.connect_src :self, :https, "https://api.pay.jp"
end

# nonce 生成
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
