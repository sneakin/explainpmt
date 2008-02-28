class MilestonesController < ApplicationController
  before_filter :find_milestone, :only => [:edit, :update, :destroy, :show]
  
  def index
    @future = @project.milestones.future
    @recent = @project.milestones.recent
  end
  
  def new
    render :update do |page|
      page.call 'showPopup', render(:partial => 'milestone_form_popup', :locals => {:url => project_milestones_path(@project)})
      page.call 'autoFocus', "milestone_name", 500
    end 
  end

  def edit
    render :update do |page|
      page.call 'cClick'
      page.call 'showPopup', render(:partial => 'milestone_form_popup', :locals => {:url => project_milestone_path(@project, @milestone)})
      page.call 'autoFocus', "milestone_name", 500
    end 
  end

  def show
    render :update do |page|
      page.call 'showPopup', render(:partial => 'milestones/show')
    end 
  end

  def create
    milestone = Milestone.new params[:milestone]
    milestone.project = @project
    render :update do |page|
      if milestone.save
        flash[:status] = "New Milestone \"#{milestone.name}\" has been created."
        page.redirect_to project_milestones_path(@project)
      else
        page[:flash_notice].replace_html milestone.errors.full_messages[0]
      end
    end    
  end
  
  def update
    render :update do |page|
      if @milestone.update_attributes(params[:milestone])
        flash[:status] = "Milestone \"#{@milestone.name}\" has been updated."
        page.call 'location.reload'
      else
        page[:flash_notice].replace_html milestone.errors.full_messages[0]
      end
    end
  end
  
  def destroy
    @milestone.destroy
    flash[:status] = "#{milestone.name} has been deleted."
    redirect_to project_milestones_path(@project)
  end
  
  def show_all
    render :update do |page|
      page[:recent].replace_html :inline => "<%= milestone_list_for @project.milestones.past, 'past_milestones' %>"
      page[:recent_title].replace_html :inline => "All Milesones <small>(<%= link_to_show_recent_milestones %>)</small>"
    end
  end
  
  def show_recent
    render :update do |page|
      page[:recent].replace_html :inline => "<%= milestone_list_for @project.milestones.recent, 'recent_milestones' %>"
      page[:recent_title].replace_html :inline => "All Milesones <small>(<%= link_to_show_all_milestones %>)</small>"
    end
  end
  
  protected
  def find_milestone
    @milestone = Milestone.find params[:id]
  end
  
end