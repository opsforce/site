---
title: Remove All Iptables PREROUTING Nat Rules
date: 2017/09/09 20:46:25
updated: 2017/09/09 20:46:25
categories:
- security
tags:
- firewall
- iptables
---
To Flush iptables PREROUTING chains cannot be achieved by -F iptables option. To remove PREROUTING nat rules from you system first display all PREROUTING chains using a following iptables command:

```
iptables -t nat --line-numbers -L
```

![](Remove%20All%20Iptables%20PREROUTING%20Nat%20Rules/02477FAB-5620-408C-9476-FFD4878A740C.png)

As you can see the above command will display all PREROUTING chains with relevant line numbers. Next, we can use these line numbers to remove all PREROUTING chains one by one. For example to remove PREROUTING chain with line number 1 we can do:

```
iptables -t nat -D PREROUTING 1
```
![](Remove%20All%20Iptables%20PREROUTING%20Nat%20Rules/568A61C7-C769-4897-8C1E-63889752495C.png)

In case that you wish to remove all PREROUTING chains with a single command you can try the following command chaining example:

```
for i in $( iptables -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac ); do iptables -t nat -D PREROUTING $i; done
```

## Reference
[Remove All Iptables PREROUTING Nat Rules](http://lubos.rendek.org/remove-all-iptables-prerouting-nat-rules/)