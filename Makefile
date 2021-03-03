

APP_CODE ?= proton-cicd
REGION ?= us-east-1
PROFILE ?= test
TEMPLATE_CODE ?= test-env

TEMPLATE_BODY_FILE ?= proton-template-cicd.cfn.yml
TEMPLATE_PARAMS_FILE ?= proton-template-cicd-$(TEMPLATE_CODE).json

.PHONY: validate-template
validate-template:
	@aws cloudformation validate-template \
  --profile $(PROFILE) \
	--template-body file://$(TEMPLATE_BODY_FILE)

.PHONY: create-stack
create-stack:
	@aws cloudformation create-stack \
  --profile $(PROFILE) \
  --stack-name $(TEMPLATE_CODE)-proton-template \
  --region $(REGION) \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://$(TEMPLATE_BODY_FILE) \
	--parameters file://$(TEMPLATE_PARAMS_FILE)

.PHONY: update-stack
update-stack:
	@aws cloudformation update-stack \
  --profile $(PROFILE) \
  --stack-name $(TEMPLATE_CODE)-proton-template \
  --region $(REGION) \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://$(TEMPLATE_BODY_FILE) \
	--parameters file://$(TEMPLATE_PARAMS_FILE)
