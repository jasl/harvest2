# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_page_layout_data

  def index
  end

  private

    def set_page_layout_data
      prepare_meta_tags title: "Home"
      @_sidebar_name = "application"
    end
end
