# Create from clone
curl https://pmx.danmanners.com/api2/json/nodes/pmx4/qemu/9000/clone -XPOST \
-H "CSRFPreventionToken: 5BBA480A:KCaRW42IE7hqrWSz1ery4xSu5cQ" \
-d 'newid=1010' \
-d 'full=1' \
-kb \
"PVEAuthCookie=PVE:root@pam:5BBA480A::GXreXFgtuDb1EBz5scHZVnyzXzVhWfufDjIMin0JbHtnS7kIGUSaYfjtboXk/d9DatrPmVEOlFmygg2g0arZv6HnmcKWIqklQuGgzu9bia2TjYDmDWu3vuBSrDyHL0WKhdjq7TkT2ETmdCMd9eI2VZCSDewiEKD2cGFTIUhlQ1eRIh7XhaIg3dz5VJ8bkgRmN9YF3ch4mTQQ1tNxs4qDHwhfhqjQ+z9Pkt91tShPouc4X4XTfObQH5Hpmd5P7aH13GgYvibjIhBr+tlkwGipBx1YV5GMo/Pf8ZGo+hemy7SqWflqeyaE+d6bmzJj7Jou1dGOxbOQhPuWOw4Vb4k8wA=="

curl https://pmx.danmanners.com/api2/json/nodes/pmx4/qemu/1010/config -XPOST \
-H "CSRFPreventionToken: 5BBA480A:KCaRW42IE7hqrWSz1ery4xSu5cQ" \
-d 'name=API-test' -d 'memory=12288' -d 'cores=4' \
-d "net0=virtio,bridge%3Dvmbr0,tag%3D105" \
-d 'ciuser=centos' -d 'vga=qxl' -d 'agent=1' -kb \
"PVEAuthCookie=PVE:root@pam:5BBA480A::GXreXFgtuDb1EBz5scHZVnyzXzVhWfufDjIMin0JbHtnS7kIGUSaYfjtboXk/d9DatrPmVEOlFmygg2g0arZv6HnmcKWIqklQuGgzu9bia2TjYDmDWu3vuBSrDyHL0WKhdjq7TkT2ETmdCMd9eI2VZCSDewiEKD2cGFTIUhlQ1eRIh7XhaIg3dz5VJ8bkgRmN9YF3ch4mTQQ1tNxs4qDHwhfhqjQ+z9Pkt91tShPouc4X4XTfObQH5Hpmd5P7aH13GgYvibjIhBr+tlkwGipBx1YV5GMo/Pf8ZGo+hemy7SqWflqeyaE+d6bmzJj7Jou1dGOxbOQhPuWOw4Vb4k8wA=="


-d 'ipconfig0=dhcp' \
