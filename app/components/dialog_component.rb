# frozen_string_literal: true

class DialogComponent < ViewComponent::Base
  def initialize(
    size: "sm",
    icon: nil,
    headline: nil,
    body: nil,
    cancel_button: nil,
    confirm_button: nil
  )
    @modal_size = "max-w-#{size}"
    @headline = headline
    @body = body
    @cancel_button = cancel_button
    @confirm_button = confirm_button
  end
end
