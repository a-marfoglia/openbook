module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Openbook"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def correct_user?
    return true if current_user && current_user == @user
    false
  end

  def triggerSignupModal?()
    return true if flash[:trigger_modal] == "signup"
    return false
  end

  def triggerLoginModal?()
    return true if flash[:trigger_modal] == "login"
    return false
  end
end
