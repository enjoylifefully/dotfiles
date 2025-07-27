#!/usr/bin/env bash

if [ $# -lt 1 ]; then
	echo "usage: $0 <target_workspace>"
	exit 1
fi

source_workspace=($(aerospace list-workspaces --focused))
target_workspace="$1"

source_window_ids=($(aerospace list-windows --workspace "$source_workspace" --format "%{window-id}"))
target_window_ids=($(aerospace list-windows --workspace "$target_workspace" --format "%{window-id}"))

for window_id in "${source_window_ids[@]}"; do
	aerospace move-node-to-workspace "$target_workspace" --window-id "$window_id"
done

for window_id in "${target_window_ids[@]}"; do
	aerospace move-node-to-workspace "$source_workspace" --window-id "$window_id"
done

aerospace workspace "$target_workspace"
