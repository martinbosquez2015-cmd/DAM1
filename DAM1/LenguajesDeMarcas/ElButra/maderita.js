document.addEventListener('DOMContentLoaded', () => {

  // --- Elementos del DOM ---
  const productDetailModal = document.getElementById('productDetailModal');
  const modalTitle = document.getElementById('modalProductTitle');
  const modalImg = document.getElementById('modalProductImg');
  const modalDescription = document.getElementById('modalProductDescription');
  const addToCartBtn = document.getElementById('addToCartBtn');
  const offcanvasCart = document.getElementById('offcanvasCart');
  const cartItemsList = document.getElementById('cartItemsList');

  // Datos simulados de productos (podrían venir de una API)
  const products = {
    'jabalí': {
      title: 'Máscara de Jabalí Inosuke',
      img: 'https://i.ibb.co/4KjVfF9/fotor-ai-2023102612002.png',
      description: 'Una réplica fiel y detallada de la icónica máscara de jabalí de Inosuke Hashibira de Demon Slayer. Fabricada con materiales ligeros para mayor comodidad, con un acabado de pelaje suave y ojos realistas.',
      price: '$45.00'
    },
    'tanto': {
      title: 'Cuchillo Tanto Réplica de Inosuke',
      img: 'https://i.ibb.co/1n5b6vP/fotor-ai-20231026120038.png',
      description: 'Réplica de exhibición de los cuchillos aserrados que usa Inosuke. Hechos de resina y metal para coleccionistas. Nota: no son para combate.',
      price: '$30.00'
    },
    'pin': {
      title: 'Pin Esmaltado Inosuke (Jabalí)',
      img: 'https://i.ibb.co/3F9j5H4/fotor-ai-20231026120054.png',
      description: 'Pin esmaltado de alta calidad con el diseño de la cabeza de jabalí de Inosuke. Perfecto para personalizar tu mochila, chaqueta o gorra.',
      price: '$8.50'
    },
    'amuleto': {
      title: 'Amuleto Péndulo Inosuke Spirit',
      img: 'https://i.ibb.co/68vL7wV/fotor-ai-20231026120111.png',
      description: 'Un elegante amuleto péndulo inspirado en la energía de Inosuke. Cristal de cuarzo y cadena metálica color bronce viejo.',
      price: '$12.00'
    },
    'colgante': {
      title: 'Colgante con Gemas Hashira Style',
      img: 'https://i.ibb.co/N1pXwY3/fotor-ai-20231026120126.png',
      description: 'Un colgante discreto con gemas de imitación azul y rojo, reflejando el espíritu indomable. Cadena incluida.',
      price: '$15.00'
    }
  };

  let currentModalProduct = null;

  // --- Lógica del Modal ---
  productDetailModal.addEventListener('show.bs.modal', (event) => {
    // Botón que disparó el modal
    const button = event.relatedTarget;
    // Extraer info de atributos data-product
    const productKey = button.getAttribute('data-product');
    currentModalProduct = products[productKey];

    // Actualizar el contenido del modal
    if (currentModalProduct) {
      modalTitle.textContent = currentModalProduct.title;
      modalImg.src = currentModalProduct.img;
      modalImg.alt = currentModalProduct.title;
      modalDescription.textContent = currentModalProduct.description;
      // Puedes añadir el precio si lo deseas en el modal también
      addToCartBtn.textContent = `Añadir al Carrito (${currentModalProduct.price})`;
    }
  });

  // --- Lógica del Carrito (Offcanvas) ---
  addToCartBtn.addEventListener('click', () => {
    // 1. Cerrar el modal de detalles
    bootstrap.Modal.getInstance(productDetailModal).hide();

    // 2. Simular añadir al carrito (añadir un ítem simple)
    const quantity = document.getElementById('quantity').value;
    addSimpleItemToCart(currentModalProduct, quantity);

    // 3. Abrir el Offcanvas del Carrito
    new bootstrap.Offcanvas(offcanvasCart).show();

    // 4. Mostrar alerta (Toast o Alert de JS)
    showAlert(`¡${quantity} unidad(es) de "${currentModalProduct.title}" añadidas al carrito con éxito!`);
  });

  // Función simple para añadir un ítem al carrito (visual)
  function addSimpleItemToCart(product, qty) {
    // Eliminar mensaje de carrito vacío si existe
    if (cartItemsList.querySelector('.text-muted')) {
        cartItemsList.innerHTML = '';
    }

    const cartItem = document.createElement('div');
    cartItem.classList.add('d-flex', 'align-items-center', 'mb-3', 'p-2', 'bg-light', 'rounded');
    cartItem.innerHTML = `
      <img src="${product.img}" alt="${product.title}" class="img-fluid rounded me-3" style="width: 50px; height: 50px; object-fit: contain;">
      <div>
        <h6 class="mb-0 fw-bold text-blue-dark">${product.title}</h6>
        <p class="mb-0 text-muted">${qty} x ${product.price}</p>
      </div>
      <span class="ms-auto text-naranja fw-bold">$${(parseFloat(product.price.replace('$', '')) * qty).toFixed(2)}</span>
    `;
    cartItemsList.appendChild(cartItem);
    updateCartTotal();
  }

  // Función para simular el total del carrito
  function updateCartTotal() {
      // Esta es una simulación simple que suma el total de cada item añadido.
      const items = cartItemsList.querySelectorAll('.text-naranja');
      let total = 0;
      items.forEach(item => {
          total += parseFloat(item.textContent.replace('$', ''));
      });

      // Actualizar el total en la UI del offcanvas
      const totalDisplay = offcanvasCart.querySelector('.offcanvas-body div.fw-bold span:last-child');
      totalDisplay.textContent = `$${total.toFixed(2)}`;

      // Habilitar botón de pago si hay items
      const payBtn = offcanvasCart.querySelector('.offcanvas-body button');
      if (total > 0) {
          payBtn.removeAttribute('disabled');
      }
  }


  // --- Función de Alerta (Toast simulado con Alert de JS por simplicidad) ---
  function showAlert(message) {
    // Bootstrap Toasts son más complejos de implementar dinámicamente con JS puro.
    // Una alerta nativa es más rápida y cumple la misma función.
    alert(message);
  }

});