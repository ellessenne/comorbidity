# Contributing

If you want to contribute to a project and make it better, your help is very welcome. 

For small, simple changes such as fixing typos you can edit any file directly from GitHub by clicking the `Edit` button after opening it. For more complicated changes, you will have to manually create a [pull request](https://help.github.com/articles/using-pull-requests) (PR) after [forking](https://help.github.com/articles/fork-a-repo) this repository. See the next section for more information. 

If you submit a non-trivial pull request (e.g. not just fixing a typo), you may add your name to the `Authors@R` field as a contributor (`ctb`) in the R package `DESCRIPTION` file if you wish.

## Pull Request Workflow

- Create a personal fork of the project on Github, and clone the fork on your local machine;
- Create a new branch to work on;
- Implement/fix your feature, comment your code;
- Follow the code style of the project, including indentation;
- Run tests using devtools: `devtools::test()`;
- Write or adapt tests as needed;
- Add or change the documentation as needed. Please do not run `roxygen2`, and do not include changes in `.Rd` files in your pull request - I will re-roxygenise the documentation myself;
- Push your branch to your fork on Github;
- From your fork open a pull request in the correct branch.

This step-by-step workflow has been adapted from https://github.com/MarcDiethelm/contributing.

**Working on your first Pull Request?** You can learn more from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github).

## Code of Conduct

By contributing to this project you agree to adhere to a Contributors Code of Conduct: please read `CONDUCT.md` before proposing any change.