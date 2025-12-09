@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View de Produtos'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_PRODUCT_FVF
  as select from ztproduct_fvf
  composition [1..*] of ZI_MOVMENT_FVF as _MOVMENTS
{
  key product_id    as ProductId,
      product_name  as ProductName,
      category      as Category,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price         as Price,
      currency_code as CurrencyCode,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at,
      _MOVMENTS // Make association public
}
