@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View de Movimentações'
@Metadata.ignorePropagatedAnnotations: true


@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_MOVMENT_FVF
  //provider contract transactional_query
  as projection on ZI_MOVMENT_FVF
{

     @Search.defaultSearchElement: true
  key MovmentId,
      @Search.defaultSearchElement: true

      @Consumption.valueHelpDefinition: [{entity: {name: 'ZI_PRODUTOS_VH_FVF', element: 'ProductId' }}]
      @ObjectModel.text.element: ['ProductName']
  key ProductId,
      _PRODUCT.ProductName as ProductName,

      MovmentType,

      Quantity,

      MovmentDate,
      LastChangedAt,
      /* Associations */
      _PRODUCT : redirected to parent ZC_PRODUCT_FVF
}
