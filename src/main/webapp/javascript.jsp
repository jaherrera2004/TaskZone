 <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Agrega event listeners a todos los botones de eliminar tarea
            document.querySelectorAll(".btn.btn-error.btn-eliminar").forEach((button) => {
                button.addEventListener("click", function (event) {
                    event.preventDefault(); // Evita que el botón ejecute su acción por defecto
                    let form = this.closest("form"); // Encuentra el formulario más cercano
                    pedirConfirmacion(form);
                });
            });

            // Agrega event listeners a todos los botones de completar tarea
            document.querySelectorAll(".btn.btn-success").forEach((button) => {
                button.addEventListener("click", function (event) {
                    event.preventDefault(); // Evita que el botón ejecute su acción por defecto
                    let form = this.closest("form"); // Encuentra el formulario más cercano
                    mostrarSatisfactorio(form);
                });
            });
        });

        function completarTarea(form) {
            // Simplemente envía el formulario para marcar la tarea como completada
            form.submit();
        }

        function pedirConfirmacion(form) {
            Swal.fire({
                title: "¿Seguro quieres eliminar la tarea?",
                text: "No podrás revertir esto",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#121213",
                confirmButtonText: "Sí, ¡elimínalo!",
                cancelButtonText: "Cancelar",
                customClass: {
                    cancelButton: 'swal2-cancel-btn-color' // Aplica la clase personalizada al botón de cancelar
                },
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si se confirma, envía el formulario
                    form.submit();
                }
            });
        }

        function mostrarSatisfactorio(form) {
            Swal.fire({
                title: "Buen trabajo!",
                text: "Haz completado la tarea",
                icon: "success"
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si se confirma, envía el formulario
                    form.submit();
                }
            });
        }
        
          document.addEventListener("DOMContentLoaded", function () {
                const maxChars = 30; // Número máximo de caracteres permitidos
                const h2Elements = document.querySelectorAll('h2'); // Selecciona todos los elementos h2

                h2Elements.forEach(function (h2) {
                    let originalText = h2.textContent;

                    if (originalText.length > maxChars) {
                            h2.textContent = originalText.substring(0, maxChars) + '...';
                        }
                    });
                })

                     
            
            document.addEventListener("DOMContentLoaded", function () {
                        const maxChars = 164; // Número máximo de caracteres permitidos
                const descElements = document.querySelectorAll('.desc'); // Selecciona todos los elementos con la clase 'desc'

                descElements.forEach(function (desc) {
                    let originalText = desc.textContent;

                    if (originalText.length > maxChars) {
                        desc.textContent = originalText.substring(0, maxChars) + '...';
                    }
                });
                        });
    </script>