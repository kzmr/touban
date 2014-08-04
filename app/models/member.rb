# -*- encoding: utf-8 -*-
class Member < ActiveRecord::Base
  self.table_name = 'touban'
  self.primary_key = :id

  attr_accessor :point

  def self.get_member(rand = false)
    order = 'id'
    if rand.present?
      order = 'rand()'
    end
    self.order(order)
  end
  def self.get_each(id)
    self.where('id=?', id).first
  end
end
