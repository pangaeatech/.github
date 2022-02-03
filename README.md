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

### 2. [Add to Redmine](.github/workflows/add-to-redmine.yml)

Adds a new issue to your [Redmine](https://redmine.org/) deployment
for the current pull request. Adds a link to the new issue to the pull request.

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
      pr_num: ${{github.event.pull_request.number}}
      pr_url: ${{github.event.pull_request.html_url}}
      pr_subject: ${{github.event.pull_request.title}}
      pr_body: ${{github.event.pull_request.body}}
      rm_url: "https://redmine.mycompany.com/"
      rm_project_id: "testproject"
      rm_tracker_id: 13
      rm_version_id: 10
      rm_field_id: 11
    secrets:
      rm_key: ${{ secrets.REDMINE_API_KEY }}
```

### 3. [Link to Redmine](.github/workflows/link-to-redmine.yml)

Links the pull request to an existing issue in your [Redmine](https://redmine.org/) deployment.

#### Example Usage:

```yaml
name: My favorite workflow
on:
  pull_request:
    types: [opened]
jobs:
  extractnum:
    runs-on: ubuntu-latest
      outputs:
        issue: ${{ steps.extract.outputs.replaced }}
      steps:
        - id: extract
          uses: frabert/replace-string-action@v2.0
          with:
            pattern: "^(task|issue|bug)(\\d+)-.*$"
            flags: "i"
            string: "${{ github.head_ref }}"
            replace-with: "$2"

  link-to-redmine:
    needs: extractnum
    if: ${{ needs.extractnum.outputs.issue != github.head_ref }}
    permissions:
      contents: read
      pull-requests: write
    uses: pangaeatech/.github/.github/workflows/link-to-redmine.yml@main
    with:
      pr_num: ${{github.event.pull_request.number}}
      pr_url: ${{github.event.pull_request.html_url}}
      rm_url: "https://redmine.mycompany.com/"
      rm_issue: ${{ needs.extractnum.outputs.issue }}
      rm_field_id: 11
    secrets:
      rm_key: ${{ secrets.REDMINE_API_KEY }}
```
