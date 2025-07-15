import tensorflow as tf
import sys
print("TensorFlow:", tf.__version__)
print("Python:", sys.version)
# Load CIFAR-10 dataset as an example
(x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar10.load_data()

x_train = tf.keras.applications.mobilenet.preprocess_input(x_train)
x_test = tf.keras.applications.mobilenet.preprocess_input(x_test)
y_train = tf.keras.utils.to_categorical(y_train, 10)
y_test = tf.keras.utils.to_categorical(y_test, 10)
 
mobilenet_base = tf.keras.applications.MobileNet(
    weights='imagenet',
    include_top=False,
    input_shape=(32, 32, 3)
)
mobilenet_base.trainable = False

model = tf.keras.models.Sequential([
    mobilenet_base,
    tf.keras.layers.GlobalAveragePooling2D(),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(10, activation='softmax')
])

model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

history = model.fit(
    x_train, y_train,
    batch_size=64,
    epochs=10,      
    validation_split=0.2,
    verbose=2
)
test_loss, test_acc = model.evaluate(x_test, y_test, verbose=2)
print(f"Test accuracy: {test_acc:.4f}")
print(f"Test accuracy: {test_acc:.4f}")

predictions = model.predict(x_test[:5])
print("Predicted classes:",
tf.argmax(predictions, axis=1).numpy())