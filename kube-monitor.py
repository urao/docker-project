import os
import subprocess
from kubernetes import client, config, watch
from kubernetes.client.rest import ApiException
from kubernetes.client.models.v1beta1_network_policy_ingress_rule import V1beta1NetworkPolicyIngressRule


config.load_kube_config(os.path.join(os.environ["HOME"], '.kube/config'))

v1 = client.CoreV1Api()
v1beta1 = client.ExtensionsV1beta1Api()

stream1 = watch.Watch().stream(v1beta1.list_network_policy_for_all_namespaces)
for event in stream1:
    print("Event: %s %s %s %s" % (event['type'], event['object'].metadata.name, event['object'].metadata.namespace, event['object'].spec.pod_selector))
    #print event
    if "deny" in event['object'].metadata.name and "ADDED" in event['type']:
        namespace=event['object'].metadata.namespace
        #print namespace
        stream2 = watch.Watch().stream(v1.list_namespaced_service, namespace)
        for event in stream2:
            print("Event: %s %s %s" % (event['type'], event['object'].metadata.name, event['object'].spec.ports[0].node_port))
            hostport=event['object'].spec.ports[0].node_port
            #print hostport
            #print event
            command = "iptables -A INPUT -p tcp --destination-port %s -j DROP" %(hostport)
            #print command
            subprocess.call(command, shell=True)
            break
        stream2.close() 
