class CommentSerializer < ActiveModel::Serializer
  attributes :content, :commenter_name, :commenter_avatar

  def commenter_name
    object.user&.name || 'guest'
  end

  def commenter_avatar
    if object.user&.avatar&.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.user.avatar, only_path: true)
    else
      ActionController::Base.helpers.asset_path('avatar.svg')
    end
  end
end
