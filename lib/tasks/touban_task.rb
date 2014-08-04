# -*- encoding: utf-8 -*-
class Tasks::ToubanTask
  class << self
    def execute
      member = ::Member.get_member

      _recommend

      print @rec_sei.name
      print @rec_fuku.name

      _update

      UserMailer.general(
        "xxxx@xxxx.com",
        "",
        "今週のプルリク当番のお知らせ",
        "
今週のプルリク当番のお知らせです。

正: #{@rec_sei.name}さん
副: #{@rec_fuku.name}さん

今週もはりきっていきましょう。
        "
      )
    end

    def _update

      member = Member::get_member
      member.each do |person|
        history = 'x'
        history = 'a' if @rec_sei.id == person.id
        history = 'b' if @rec_fuku.id == person.id
        history << person.history[0,4]
        person.history = history
        person.updated_at = Time.now
        person.save!
      end

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

      if @rec_fuku.id == @rec_sei.id
        @rec_fuku = member.pop
      end



    end
  end
end
