@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composition Child Entity - To Parent (Product)'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_MOVMENT_FVF as select from ztmovment_fvf
association to parent ZI_PRODUCT_FVF as _PRODUCT   on $projection.ProductId = _PRODUCT.ProductId
{
    key movment_id as MovmentId,
    key product_id as ProductId,
    movment_type as MovmentType,
    quantity as Quantity,
    movment_date as MovmentDate,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at as LastChangedAt,
    _PRODUCT // Make association public
}
