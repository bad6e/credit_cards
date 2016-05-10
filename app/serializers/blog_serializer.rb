class BlogSerializer < ActiveModel::Serializer
  attributes :id, :slug, :meta_title, :meta_description, :day, :month, :image_url, :related_image_url

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

