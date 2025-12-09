@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View de Produtos'
@Metadata.ignorePropagatedAnnotations: true



@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_PRODUCT_FVF
  provider contract transactional_query
  as projection on ZI_PRODUCT_FVF
{


      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['ProductName']
  key ProductId,

      ProductName,

      Category,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,

      created_by,
      created_at,
      last_changed_by,
      last_changed_at,
      /* Associations */
      _MOVMENTS : redirected to composition child ZC_MOVMENT_FVF 
}
