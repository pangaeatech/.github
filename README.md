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

> ### Dependency Trees for "ws"
>
> ```
> api@1.0.0 /home/runner/work/project/project/api
> └─┬ jest@27.4.7
>   └─┬ @jest/core@27.4.7
>     └─┬ jest-config@27.4.7
>       └─┬ jest-environment-jsdom@27.4.6
>         └─┬ jsdom@16.7.0
>           └── ws@7.5.6
>
> docs@1.0.0 /home/runner/work/project/project/docs
> └── (empty)
>
> wwwroot@0.1.0 /home/runner/work/project/project/wwwroot
> └─┬ react-scripts@4.0.3
>   ├─┬ jest-circus@26.6.0
>   │ └─┬ jest-runner@26.6.3
>   │   └─┬ jest-config@26.6.3
>   │     └─┬ jest-environment-jsdom@26.6.2
>   │       └─┬ jsdom@16.4.0
>   │         └── ws@7.5.6
>   └─┬ webpack-dev-server@3.11.1
>     └── ws@6.2.2
> ```
