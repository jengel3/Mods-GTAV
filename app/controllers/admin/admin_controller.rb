class Admin::AdminController < ApplicationController
  before_filter :require_admin
end
