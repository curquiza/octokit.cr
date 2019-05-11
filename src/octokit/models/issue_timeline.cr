module Octokit
  module Models
    struct Timeline
      rest_model(
        id: Int64,
        url: String,
        commit_url: String,

        actor: User,

        event: String,

        commit_id: String,

        created_at: String,

        label: Label?,

        assignee: User?,

        milestone: User?,

        source: Source?,

        rename: Rename?,
        project_card: ProjectCard?
      )
    end

    struct Source
      rest_model(
        id: Int64,
        url: String,
        actor: User,
        type: String,
        issue: Issue
      )
    end
  end
end
