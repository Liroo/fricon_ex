# Contributing to the Fricon project

Welcome in the little guide of how you can contribute to the fricon project.

## Prelude

Please be descriptive in every case. Please write in english. Please review carefuly. Please test the code before shipping it. Please write well code.

## Issue

Spotted a bug? FINE! I like it! So please submit an [issue](https://github.com/ulysse-travel/ulysse-web/issues).

Issue can be a question or simply a bug. Keep in mind that issue is about the fricon project, so do not start a conversation outside the bounds. However, We can discuss about a new feature or things are done a way or another. 

## Pull Request

> Issue is not required to start a Pull Request. And Pull Request is not an automatic end to an Issue.

We are following the [git flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) model.

There's some rules to make a good PR:

### The first step, create your branch

#### Branch naming convention

The branch naming is really important, it should be descriptive and be prefixed by the kind of the branch.

Here bellow the potential kind of a branch.

Prefix kind | Description
------------ | -------------
`feat` | A new feature
`enhancement` | A part of the code who is optimized or enhanced
`chore` | Used for refacto or misc things
`fix` | Fix a specific bug
`hotfix` | Fix a specific bug directly on master because of importance

Some example of branch name:

- good: `feat/provider-amadeus` -> new provider amadeus
- good: `fix/provider-behaviour` -> a fix that happen on the behaviour of provider
- good: `chore/unused-file` -> certainly a cleanup of unused files
- good: `enhancement/currency-docs` -> an update of the currency documentation
- bad: `hotfix/fricon` -> an hotfix on the project itself is not descriptive enough
- bad: `f/currency-docs` -> an update of the currency documentation

### In the Pull Request list, we know what is the purpose

#### Pull Request title

The title must follow the branch name convention as expect the `/`, it should be as `prefix(suffix): description`. So for the branch `feat/provider-amadeus`, the Pull Request title could be:

`feat(provider-amadeus): implement new provider amadeus`

If a Pull Request follow a clubhouse issue, it's a good practice to include the clubhouse ticket id in the title as:

`feat(provider-amadeus): implement new provider amadeus (ch-0001)`

#### Pull Request labels

Labels are not optionnal. It's more confortable in the list to search for a color than a black on white text. So please be aware of labels that currently exists and put the correct labels.

As well as when a developer approved a PR, he should put the label `approved`. When the PR is `approved` and tested (with the label `tested`), the PR can be merged and deployed.

In fact the label `tested` is not mandatory but it is a good practice.

### Inside of a Pull Request

#### Description

Description is a brief introduction to the pull request. You could describe what you've done without explaining each line.

Use well markdown and PLEASE write a description! A title is not enough.

#### Commit messages and git history

The history is not only cool and pretty. It's really useful and IMPORTANT in order to track bugs and revert if necessary!

Use the same convention as Pull Request title. As `prefix(suffix): description`. And please use descriptive description.

Ie: `enhancement(currency-doc): add documentation for the function Currency.change_currency/2`

### Mandatory stuff

- When it's needed, rebase the PR using `git rebase` to the desired branch
- Checkout the gitflow model in order to know how branch merge direction works

### Final though

A commit needs to be treated as a Pull Request. A commit needs to work alone, so if we checkout to specific commit, the code should be runnable as if we checkout to a specific Pull Request. that's why you need to make a good history in the Pull Request.

A Pull Request is made of ONLY one purpose. You will not mix a feature and an enhancement in the same PR. You will not put two features in the same PR. You will also take care as if you PR is too long, to split it in two separate PR. If a PR is more than 10-15 files. There's probably a problem with your PR.