class MainProgramSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url
  has_many :card_programs
end