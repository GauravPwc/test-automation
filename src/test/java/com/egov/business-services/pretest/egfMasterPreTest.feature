Feature: Pretest scenarios of egf-master service end points
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml') 
  * def typeName = randomString(10)
  * def tableName = egfMasterConstants.chartOfAccountDeatails.params.tableName
  * def fullyQualifiedName = randomString(3)+"/"+tableName
  * def description = 'TEST_'+randomString(5)
  * def active = egfMasterConstants.chartOfAccountDeatails.params.active
  * def chartOfAccountCreatePayload = read('../../business-services/requestPayload/egfMaster/chartOfAccount/create.json')
  * def chartOfAccountSearchPayload = read('../../business-services/requestPayload/egfMaster/chartOfAccount/search.json')
  * def chartOfAccountUpdatePayload = read('../../business-services/requestPayload/egfMaster/chartOfAccount/update.json')
  * def accountDetailsTypePayload = read('../../business-services/requestPayload/egfMaster/accountDetailsType.json')
  * def accountDetailsUpdatePayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/update.json')
  * def createBankBranchPayload = read('../../business-services/requestPayload/egfMaster/bankBranches/create.json')
  * def updateBankBranchPayload = read('../../business-services/requestPayload/egfMaster/bankBranches/update.json')
  * def searchBankBranchPayload = read('../../business-services/requestPayload/egfMaster/bankBranches/search.json')

  
@createAccountSuccessfully
  Scenario: Creating chart of accounts through API call
    * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url chartOfAccountCreate 
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
    When method post
    Then status 201
    And def chartOfAccountCreateResponseHeader = responseHeaders
    And def chartOfAccountCreateResponseBody = response
    And def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].name
    And def functionRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].functionRequired
    And def type = chartOfAccountCreateResponseBody.chartOfAccounts[0].type
    And def classification = chartOfAccountCreateResponseBody.chartOfAccounts[0].classification
    And def glcode = chartOfAccountCreateResponseBody.chartOfAccounts[0].glcode
    And def isActiveForPosting = chartOfAccountCreateResponseBody.chartOfAccounts[0].isActiveForPosting
    And def id = chartOfAccountCreateResponseBody.chartOfAccounts[0].id
    And def budgetCheckRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].budgetCheckRequired
    And def chartAccountId = response.chartOfAccounts[0].id
    And def chartAccountGlcode = response.chartOfAccounts[0].glcode
    And def chartAccountName = response.chartOfAccounts[0].name
    And def chartOfAccountResponse = response

@errorInAccoutCreate
  Scenario: Creating chart of accounts and check for error through API call
    * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url chartOfAccountCreate
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
      * print chartOfAccountCreatePayload
    When method post
    Then status 400
    And def chartOfAccountCreateResponseHeader = responseHeaders
    And def chartOfAccountCreateResponseBody = response

@unauthorizedaccessError
  Scenario: Creating chart of accounts and check for errors through API call
    * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url chartOfAccountCreate
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
    When method post
    Then status 403
    And def chartOfAccountResponseHeader = responseHeaders
    And def chartOfAccountResponseBody = response

# Chart of account search pretest
@searchAccountSuccessfully
  Scenario: Searching chart of accounts through API call
    * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)',
     id: '#(id)',
     glcode: '#(glcode)',
     type: '#(type)',
     classification: '#(classification)',
     name: '#(name)',
     isActiveForPosting: '#(isActiveForPosting)'
    }
    """ 
    Given url charOfAccountSearch
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 200
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

@searchWithTenantIdSuccessfully
  Scenario: Searching chart of accounts with TenantId through API call
    * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url charOfAccountSearch 
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 200
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

@errorInSearchAccount
  Scenario: Searching chart of accounts and check for error through API call
    * def chartOfAccountSearcheParam = 
    """
    {
     id: '#(id)',
     glcode: '#(glcode)',
     classification: '#(classification)',
     name: '#(name)',
     type: '#(type)',
     isActiveForPosting: '#(isActiveForPosting)'
    }
    """ 
    Given url charOfAccountSearch 
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 400
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

# Chart of Account Update
@updateAccountSuccessfully
  Scenario: Updating chart of accounts through API call
    * def chartOfAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url chartOfAccountUpdate
     And params chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     When method post
     Then status 201
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response

@errorInUpdateAccount
Scenario: Updating chart of accounts and check for error through API call
    * def chartOfAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url chartOfAccountUpdate 
     And params chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     When method post
     Then status 400
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response

    # Pretest scenarios for ChartOfAccountDetails service

  @createAccountDetailsType
    Scenario: To create account details type
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url accountDetailsType
    And params params
    And request accountDetailsTypePayload
    When method post
    Then status 201
    And def accountTypeId = response.accountDetailTypes[0].id
    And def accountTypeName = response.accountDetailTypes[0].name
    And def accountTypeDescription = response.accountDetailTypes[0].description
    And def accountTypeTableName = response.accountDetailTypes[0].tableName
    And def accountTypeIsActive = response.accountDetailTypes[0].active
    And def accountTypefullyQualifiedName = response.accountDetailTypes[0].fullyQualifiedName
    And def accountDetailsTypeResponse = response
  
@createChartOfAccountDetails
    Scenario: To create chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url createAccountDetails
    And params params
    And request requestPayload
        * print requestPayload
    When method post
    Then assert responseStatus == 201
    And def accountDetailsCreateResponse = response

@errorInCreateChartOfAccountDetails
    Scenario: Negative pretest to create chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url createAccountDetails
    And params params
    And request requestPayload
        * print requestPayload
    When method post
    Then assert responseStatus == 500 || responseStatus == 403
    And def accountDetailsCreateResponse = response

@updateChartOfAccountDetails
    Scenario: To update chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url updateAccountDetails
    And params params
    And request requestPayloadToUpdate
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 201
    And def updateResponse = response

@errorInUpdateChartOfAccountDetails
    Scenario: Negative pretest to update chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url updateAccountDetails
    And params params
    And request requestPayloadToUpdate
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def updateResponse = response
    
@searchChartOfAccountDetails
    Scenario: To search chart of account details
    Given url searchAccountDetails
    And params searchAccountDetailsParams
        * print searchAccountDetailsParams
    And request requestPayloadToSearch
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 200
    And def searchResponse = response

@errorInSearchChartOfAccountDetails
    Scenario: Negative pretest to search chart of account details
    Given url searchAccountDetails
    And params searchAccountDetailsParams
        * print searchAccountDetailsParams
    And request requestPayloadToSearch
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 403
    And def searchResponse = response
  
  # Pretest scenarios for Bank Service
  @createBank
    Scenario: To create Bank
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankCreate
    And params params
    And request createBankPayload
        * print createBankPayload
    When method post  
    Then assert responseStatus == 201
    And def createBankResponse = response
    And def bankId = createBankResponse.banks[0].id

@errorInCreateBank
    Scenario: Negative pretest to create Bank
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankCreate
    And params params
    And request createBankPayload
        * print createBankPayload
    When method post
    Then assert responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def createBankResponse = response

@updateBank
    Scenario: To update Bank
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankUpdate
    And params params
    And request updateBankPayload
        * print updateBankPayload
    When method post
    Then assert responseStatus == 201
    And def updateBankResponse = response

@errorInUpdateBank
    Scenario: Negative pretest to update Bank
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankUpdate
    And params params
    And request updateBankPayload
        * print updateBankPayload
    When method post
    Then assert responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def updateBankResponse = response

@searchBank
    Scenario: To search Bank
    Given url bankSearch
    And params searchParams
        * print searchParams
    And request searchBankPayload
    When method post
      * print responseStatus
    Then assert responseStatus == 200
    And def searchBankResponse = response

@errorInSearchBank
    Scenario: Negative pretest to search Bank
    Given url bankSearch
    And params searchParams
        * print searchParams
    And request searchBankPayload
    When method post
      * print responseStatus
    Then assert responseStatus == 403 || responseStatus == 400
    And def searchBankResponse = response

# Pretest scenarios for Bank Branch Service
  @createBankBranch
    Scenario: To create Bank Branch
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankBranchCreate
    And params params
    And request createBankBranchPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def createBankBranchResponse = response
    * def bankBranches = createBankBranchResponse.bankBranches

@createBankBranchWithInvalidTenantId
    Scenario: To create Bank Branch
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url bankBranchCreate
    And params params
    * eval createBankBranchPayload.tenantId = 'InvalidTenantId-'+randomString(10)
    And request createBankBranchPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def createBankBranchResponse = response

@createBankBranchWithoutParams
    Scenario: To create Bank Branch
    Given url bankBranchCreate
    And request createBankBranchPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def createBankBranchResponse = response
    * def bankBranches = createBankBranchResponse.bankBranches

@updateBankBranch
    Scenario: To update Bank Branch
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    * eval updateBankBranchPayload.bankBranches = bankBranches
    Given url bankBranchUpdate
    And params params
    And request updateBankBranchPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def updateBankBranchResponse = response

@searchBankBranch
    Scenario: To search Bank Branch
    Given url bankBranchSearch
    And params searchParams
        * print searchParams
    And request searchBankBranchPayload
    When method post
    Then assert responseStatus == 200 || responseStatus == 403 || responseStatus == 400
    And def searchBankBranchResponse = response
    * print searchBankBranchResponse