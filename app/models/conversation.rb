# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#

class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  scope :my_conversations, -> (user_id) do
    where("conversations.sender_id = ? OR conversations.recipient_id =?", user_id, user_id)
  end

  scope :to_me, -> (user_id) do
    joins(:messages).my_conversations(user_id).where('messages.read = false and messages.user_id <> :user_id',
      user_id: user_id).uniq
  end
end
