# mytodolist

### AWS lambda mounted via API gateway, managed by terraform

## Prerequisites
* Java 11
* Maven 3
* GNU make
* [tfvm](https://github.com/cbuschka/tfvm) or Terraform 0.13.4

## Usage

* Deployment
```
make deploy_service
```

* Undeployment
```
make destroy_service
```

## License
Copyright 2020 by Cornelius Buschka. All rights reserved.

[Apache Public License 2.0](./license.txt)