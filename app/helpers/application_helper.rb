module ApplicationHelper
  def flash_accent_class(key)
    case key.to_s
    when 'success', 'notice'
      'bg-emerald-500'
    when 'error', 'alert'
      'bg-red-500'
    else
      'bg-slate-500'
    end
  end
end
