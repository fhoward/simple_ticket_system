module FlashHelper
  def bootstrap_flash_class(flash_type)
    case flash_type
    when 'notice'
      'alert alert-success'
    when 'alert', 'error'
      'alert alert-danger'
    else
      'alert alert-info'
    end
  end
end
