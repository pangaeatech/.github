## Pangaea Reusable Workflows

A collection of publicly available [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows).

### [Annotate NPM Dependencies](.github/workflows/annotate-npm-dependencies.yml)

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
```

#### Example Output:

![Example Output](images/annotate-npm-dependencies.png)
