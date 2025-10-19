# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_task_id  (task_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :commenter_name, :commenter_avatar, :is_owner

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

  def is_owner
    scope.present? && object.user_id == scope.id
  end
end
