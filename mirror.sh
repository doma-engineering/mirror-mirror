#!/usr/bin/env bash

# Readme for this script:
#
# This script will clone all the repositories from a GitHub organization.
# It uses gh, a GitHub CLI tool, and jq, a JSON parser.
# You can install it with nix: nix shell nixpkgs#gitAndTools.gh nixpkgs#jq. Run `shell.sh` to do that.
# But this script comes with flake.nix, so you can just run it with direnv with direnv allow.

# Usage information and help.
usage() {
  echo "Usage: $0 [organization] [limit]"
  echo "  organization: The name of the organization to fetch the repositories from. If not provided, it will be 'doma-engineering'."
  echo "  limit: The amount of the repositories to fetch. If not provided, it will be the amount of repositories the organization has."
  echo "Example: $0 doma-engineering 10"
}

# If first argument is -h or --help, print usage information and exit.
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

# Check if we're logged into GitHub with gh.
if ! gh auth status; then
  gh auth login
fi

#### LET'S GO ####

# First argument is the name of the organization. If not provided, it will be "doma-engineering".
ORG=${1:-doma-engineering}

# Get all the repositories from the organization.
REPOS="$(gh api "https://api.github.com/orgs/$ORG/repos" | jq '.[].name')"
REPOS_AMOUNT="$(wc -l <<< "$REPOS")"

# Second argument is the amount of the repositories to fetch. If not provided, it will be the amount of repositories the organization has.
LIMIT=${2:-$REPOS_AMOUNT}

# Clone all repos from a GitHub organization.
gh repo list doma-engineering --limit "$LIMIT" | while read -r repo _; do
  # Check if the repo isn't cloned yet. Note that $repo has $ORG as the prefix.
  if [[ -d "$repo" ]]; then
    cd "$repo" || exit 1
    # Pull the latest changes.
    git pull
  # Else clone it into "$repo" with gh.
  # It uses `clone "$repo" "$repo"` to trick gh into cloning the repo into a super-directory with the same name as organisation.
  else
    gh repo clone "$repo" "$repo"
  fi
done