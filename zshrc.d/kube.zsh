KUBECONFIG="${HOME}/.kube/config"

for CONFIG_FILE in ~/.kube/config.d/*.yaml; do
  [ -r "${CONFIG_FILE}" ] && KUBECONFIG="${KUBECONFIG}:${CONFIG_FILE}"
done

export KUBECONFIG
