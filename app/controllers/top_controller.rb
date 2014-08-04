# -*- encoding: utf-8 -*-
class TopController < ActionController::Base
  layout 'application'
  def index
    @member = Member::get_member
    @member.each do |item|
      @updated_at = item.updated_at
      break;
    end
    _current
  end

  def next
    @member = Member::get_member
    _current

    if request.post?
      if params[:sei_id] != params[:fuku_id]
        @member.each do |person|
          history = person.history
          if person.id == @sei.id || person.id == @fuku.id
            history[0] = 'x'
          end
          if person.id == params[:sei_id].to_i
            history[0] = 'a'
          elsif person.id == params[:fuku_id].to_i
            history[0] = 'b'
          end

          each = Member::get_each person.id
          each.history = history
          each.updated_at = Time.now

          each.save!
        end
        flash[:message] = '当番を変更しました。'
      else
        flash[:message] = '正と副はちがう人にしてください。'
      end
    end

    _current
  end

  def history
    @member = Member::get_member
  end

  def _recommend
    @rec_sei = ''
    @rec_fuku = ''
    member = Member::get_member true
    member.each do |person|
      point = 0
      person.history.each_char.with_index do |history, index|
        if history == 'a'
          point = point + (5-index)*2
        elsif history == 'b'
          point = point + (5-index)*1
        end
      end
      person.point = point

      if @rec_sei.blank?
        @rec_sei = person
        @rec_fuku = person
      elsif @rec_sei.point >= point
        @rec_fuku = @rec_sei
        @rec_sei = person
      elsif @rec_fuku.point >= point
        @rec_fuku = person
      end
    end
  end

  def _current
    @sei = ''
    @fuku = ''
    member = Member::get_member
    member.each do |person|
      @sei = person if person.history[0] == 'a'
      @fuku = person if person.history[0] == 'b'
    end
  end
end
