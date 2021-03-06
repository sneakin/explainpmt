module MilestonesHelper
  def link_to_new_milestone
    link_to_remote 'Add Milestone', :url => new_project_milestone_path(@project), :method => :get
  end

  def link_to_edit_milestone(milestone, options={})
    link_to_remote(options[:value] || milestone.name, :url => edit_project_milestone_path(@project, milestone), :method => :get)
  end

  def option_to_edit_milestone(milestone)
    create_action_option("Edit", edit_project_milestone_path(@project, milestone))
  end

  def option_to_delete_milestone(milestone)
    create_action_option("Delete", project_milestone_path(@project, milestone), :method => :delete, :confirm => "Are you sure you want to delete?")
  end

  def link_to_show_all_milestones
    link_to_remote 'show all', :url => show_all_project_milestones_path(@project), :method => :get
  end

  def link_to_show_recent_milestones
    link_to_remote 'show recent', :url => show_recent_project_milestones_path(@project), :method => :get
  end

  def milestone_list_for(milestones, table_id)
    render :partial => 'milestones', :locals => {:milestones => milestones, :table_id => table_id }
  end

  def past_milestones
    milestone_list_for @project.milestones.past, 'past_milestones'
  end

  def recent_milestones
    milestone_list_for @project.milestones.recent, 'recent_milestones'
  end

  def link_to_show_milestone(milestone, options={})
    link_to_remote(options[:value] || milestone.name, :url => project_milestone_path(milestone.project, milestone), :method => :get)
  end
end
