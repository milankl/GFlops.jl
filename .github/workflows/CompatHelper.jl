name: CompatHelper

on:
  schedule:
    - cron: '00 * * * *'
  issues:
    types: [opened, reopened]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        julia-version: [1.2.0]
        julia-arch: [x86]
        os: [ubuntu-latest]
    steps:
      - uses: julia-actions/setup-julia@latest
        with:
          version: ${{ matrix.julia-version }}
      - name: Pkg.add("CompatHelper")
        run: julia -e 'using Pkg; Pkg.add("CompatHelper")'
      - name: CompatHelper.main()
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: julia -e 'using CompatHelper; CompatHelper.main()'
