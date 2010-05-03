class Admin::BaseController < ApplicationController
  layout 'administration'
  before_filter :require_user
end