# coding: utf-8
# frozen_string_literal: true

class Goal < ActiveRecord::Base
  include I18n::Alchemy
  belongs_to :project

  validates_numericality_of :value, greater_than: 9, allow_blank: false
  validates_presence_of :description

end
