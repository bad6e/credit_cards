class BlogSerializer < ActiveModel::Serializer
  attributes :id, :slug, :meta_title, :meta_description, :title, :author, :content, :day, :month

  def day
    object.created_at.day
  end

  def month
    object.created_at.strftime("%b")
  end

  def content
    object.content.split.slice(0, 75).push("...").join(" ")
  end
end

