typeset -gx KUBECONFIG=$HOME/.kube/config

for _config_file (~/.kube/*.yaml(N)); do
	[[ -r $_config_file ]] && KUBECONFIG+=:$_config_file
done
unset _config_file
