{include file="templates/header.tpl"}

{*Navs diferentes para los templates*}
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="login">Login</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="{BASE_URL}">Home</a>
        </li>  
         <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="allCars">All Cars</a>
        </li>  
      </ul>
    </div>
    <div class="d-flex">
      <a href="logout"><button class="btn btn-danger" type="submit">Sign off</button></a>
    </div>
  </div>
</nav>

<div class="container">   
    <div class="forms">
        <div class="form-car">
            <h1>Create Car</h1>
            <form action="createCar" method="post">    
                <div class="mb-3">        
                    <label for="enter-car" class="form-label">Enter Car</label>
                    <input type="text" name="car" class="form-control" id="enter-car">    
                </div>
                <select name="brand" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                    {*Seleccionamos (el id de) la marca para el auto*}
                    {foreach from=$allBrands item=$brand}
                        <option value="{$brand->id_brand}">{$brand->brand}</option> 
                    {/foreach}
                </select>
                <div class="mb-3">
                    <label for="enter-year" class="form-label" >Year</label>
                    <input type="number" name="year" class="form-control" id="enter-year"> 
                </div>
                <div class="form-floating">
                    <textarea name="description" class="form-control" placeholder="Leave a description here" id="floatingTextarea"></textarea>
                    <label for="floatingTextarea">Description</label>
                </div>
                <div class="mb-3 form-check">   
                    <input type="checkbox" name="sold" class="form-check-input" id="check-car">  
                    <label class="form-check-label" for="check-car">On sale - Sold</label>
                </div>      
                <div class="mb-3">
                    <label for="enter-price" class="form-label" >Euro Price</label>
                    <input type="number" name="euro"class="form-control" id="enter-price"> 
                </div>  
                <button type="submit" class="btn btn-primary">Register</button>      
            </form>
            <form action="saveImgCar" method="post" enctype="multipart/form-data"> 
                <div class="mb-3">        
                    <label for="enter-car-img" class="form-label" >Enter Car Img</label>
                    <input type="text" name="car" class="form-control" id="enter-car-img">    
                </div>
                {*Enviamos el id de la auto para relacionar la imagen con el auto correspondiente*}
                {foreach from=$id item=$item}
                    <input type="hidden" name="id" value="{$item->id}">
                {/foreach}   
                <div class="mb-3">
                    <label for="enter-logo" class="form-label" >Logo</label>
                    <input type="file" name="photo" class="form-control" id="enter-logo"> 
                </div>    
                <button type="submit" class="btn btn-primary">Register Image</button>  
            </form>
        </div>
        
        <div class="form-brand">
            <h1>Create Brand</h1>
            <form action="saveLogo" method="post" enctype="multipart/form-data"> 
                <div class="mb-3">
                    <label for="enter-brand" class="form-label" >Enter Brand</label>
                    <input type="text" name="brand"  class="form-control" id="enter-brand">        
                </div>
                <div class="mb-3">
                    <label for="enter-logo" class="form-label">New Logo</label>
                    <input type="file" name="photo" class="form-control" id="enter-logo"> 
                </div>   
                <button type="submit" class="btn btn-primary">Register Logo</button>  
            </form>
            <form action="createBrand" method="post"> 
                <select name="brand" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                    {*Como primero creamos el logo de la marca y despues la marca, seleccionamos la marca ya creada en la tabla logo*}
                    {foreach from=$brandsLogo item=$item}
                        <option value="{$item->brand}">{$item->brand}</option> 
                    {/foreach}
                </select>
                <div class="form-floating">
                    <textarea name="descriptionBrand" class="form-control" placeholder="Leave a description here" id="floatingTextarea"></textarea>
                    <label for="floatingTextarea">Description New Brand</label>
                </div> 
                {*Enviamos el id del logo para relacionar la marca con el logo correspondiente, 1 marca puede tener diferentes logos*} 
                {foreach from=$idLogo item=$item}
                    <input type="hidden" name="idlogo" value="{$item->id_logo}">
                {/foreach}
                <button type="submit" class="btn btn-primary">Register New Brand</button>   
            </form>   
            <br>
            <form action="modifiedName" method="POST">  
                <h1>Modify the name of a brand</h1>
                <div class="mb-3">
                    <label for="enter-brand" class="form-label">New Name Brand</label>
                    <input type="text" name="newName"  class="form-control" id="enter-brand">        
                </div>           
                <div class="mb-3">
                    <label for="enter-brand" class="form-label">Brand to modify</label>
                    <input type="text" name="nameModified"  class="form-control" id="enter-brand">        
                </div>  
                <button type="submit" class="btn btn-primary">Save Modified</button>
            </form>    
        </div>
    </div> 
    
    <div class="card-brands">
        {foreach from=$allBrands item=$brand}                           
            <div class="card" style="width: 18rem;">   
                <img src="data:image/jpg;base64,{$brand->image}" class="card-img-top" alt="{$car->brand} Logo"> 
                <div class="card-body">
                    <h5 class="card-title">{$brand->brand}</h5>
                    <p class="card-text">{$brand->description}</p>                            
                    <a href="brand/{$brand->brand}" class="btn btn-primary">Go Cars</a>
                    {*Antes de eliminar la marca, elimino los autos de esa marca*}
                    {foreach from=$allBrandsAndCar item=$brands} 
                        {if $brand->brand == $brands->brand || !$brands->car}
                            <a href="deleteBrand/{$brand->brand}/{$brands->car}" class="btn btn-danger">Delete</a>
                        {/if}
                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div> 
</div>

{include file="templates/footer.tpl"}