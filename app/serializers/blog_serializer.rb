class BlogSerializer < ActiveModel::Serializer
  attributes :id, :meta_title, :meta_description, :title, :author, :content, :day, :month

  def day
    object.created_at.day
  end

  def month
    object.created_at.strftime("%b")
  end
end

