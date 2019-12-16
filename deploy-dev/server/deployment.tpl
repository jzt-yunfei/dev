---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    k8s.eip.work/layer: svc
    k8s.eip.work/name: svc-{server-name}
  name: svc-{server-name}
  namespace: {k8s-namespace}
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s.eip.work/layer: svc
      k8s.eip.work/name: svc-{server-name}
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        k8s.eip.work/layer: svc
        k8s.eip.work/name: svc-{server-name}
    spec:
      containers:
        - image: '{docker-image}'
          imagePullPolicy: Always
          name: {server-name}
      dnsPolicy: ClusterFirst
      imagePullSecrets:
        - name: dy-test-registry
      restartPolicy: Always
      schedulerName: default-scheduler

---
apiVersion: v1
kind: Service
metadata:
  labels:
    k8s.eip.work/layer: svc
    k8s.eip.work/name: svc-{server-name}
  name: svc-{server-name}
  namespace: {k8s-namespace}
spec:
  ports:
    - name: {server-name}
      port: 8080
      protocol: TCP
      targetPort: 8080
  selector:
    k8s.eip.work/layer: svc
    k8s.eip.work/name: svc-{server-name}
  sessionAffinity: None
  type: ClusterIP

---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  labels:
    k8s.eip.work/layer: svc
    k8s.eip.work/name: svc-{server-name}
  name: svc-{server-name}
  namespace: {k8s-namespace}
spec:
  rules:
    - host: {server-name}.douya.com
      http:
        paths:
          - backend:
              serviceName: svc-{server-name}
              servicePort: {server-name}
            path: /
