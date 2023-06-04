resource "null_resource" "srv" {
  count = var.srv
  depends_on = [yandex_compute_instance.srv]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.srv[count.index].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    
    inline = [
      #добавляем пользователя в группу docker
      "sudo usermod -aG docker $USER",
      #устаналиваем yc
      "sudo curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a",
      #подключаем yc к облаку
      "~/yandex-cloud/bin/yc config set token ${var.ya_token}",
      #устаналиваем gitlab-runner
      "sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64",
      "sudo chmod +x /usr/local/bin/gitlab-runner",
      "sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner",
      "sudo gitlab-runner start",
      "echo COMPLETED",
      #регистрируем gitlab-runner
      "sudo gitlab-runner register --non-interactive --url https://gitlab.com --registration-token ${var.gitlab_token} --executor \"shell\" --run-untagged=\"true\" --pre-clone-script \"sudo chown -R gitlab-runner:gitlab-runner .\"",
      #устанавливаем kubectl
      "sudo apt-get update && sudo apt-get install -y apt-transport-https",
      "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee -a /etc/apt/sources.list.d/kubernetes.list",
      "sudo apt-get update",
      "sudo apt-get install -y kubectl",
      #настраиваем подключение к Kubernetes cluster
      "~/yandex-cloud/bin/yc managed-kubernetes cluster get-credentials '${var.k8s_cluster_id}' --internal",
      "sudo kubectl cluster-info",
      #устанавливаем helm
      "curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null",
      "sudo apt-get install apt-transport-https --yes",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main\" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list",
      "sudo apt-get update",
      "sudo apt-get install helm",
      "rm ~/.bash_logout"
    ]
  }
}