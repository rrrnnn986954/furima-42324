Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https, "https://js.pay.jp"
  policy.style_src   :self, :https
  policy.frame_src   :self, :https, "https://js.pay.jp"
  policy.connect_src :self, :https, "https://api.pay.jp"
end

# Rails が自動で1つの nonce を生成するように設定
Rails.application.config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
