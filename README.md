## Pangaea Reusable Workflows

A collection of publicly available [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows).

### 1. [Annotate NPM Dependencies](.github/workflows/annotate-npm-dependencies.yml)

Updates a pull request created by dependabot for an NPM-based dependency to
identify the direct dependencies that are impacted.

#### Example Usage:

```yaml
name: My favorite workflow
on:
  pull_request:
    types: [opened, synchronize, reopened]
jobs:
  annotate-npm-dependencies:
    if: ${{ github.actor == 'dependabot[bot]' }}
    permissions:
      contents: read
      pull-requests: write
    uses: pangaeatech/.github/.github/workflows/annotate-npm-dependencies.yml@main
    with:
      pr_url: ${{github.event.pull_request.html_url}}
      branch: ${{github.head_ref}}
```

#### Example Output:

![Example Output](images/annotate-npm-dependencies.png)

### 2. [Add To Redmine](.github/workflows/add-to-redmine.yml)

Adds a new issue to your company's [Redmine](https://redmine.org/) deployment
using the REST API for the current pull request. Adds a comment to the pull
request with a link to the new issue.

#### Example Usage:

```yaml
name: My favorite workflow
on:
  pull_request:
    types: [opened]
jobs:
  add-to-redmine:
    if: ${{ github.actor == 'dependabot[bot]' }}
    permissions:
      contents: read
      pull-requests: write
    uses: pangaeatech/.github/.github/workflows/add-to-redmine.yml@main
    with:
      pr_url: ${{github.event.pull_request.html_url}}
      pr_subject: ${{github.event.pull_request.title}}
      pr_body: ${{github.event.pull_request.body}}
      rm_url: "https://redmine.mycompany.com/"
      rm_project_id: "testproject"
      rm_tracker_id: 13
      rm_version_id: 10
    secrets:
      rm_key: ${{ SECRETS.REDMINE_API_KEY }}
```
