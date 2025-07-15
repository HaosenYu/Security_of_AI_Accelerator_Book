import tensorflow as tf
import sys
print("TensorFlow:", tf.__version__)
print("Python:", sys.version)


def depthwise_separable_conv_block(x, filters, kernel_size=(3, 3), strides=(1, 1), alpha=1.0):
    filters = int(filters * alpha)

    x = tf.keras.layers.DepthwiseConv2D(
        kernel_size=kernel_size,
        strides=strides,
        padding='same'
    )(x)
    x = tf.keras.layers.BatchNormalization()(x)
    x = tf.keras.layers.ReLU()(x)

    x = tf.keras.layers.Conv2D(
        filters,
        kernel_size=(1, 1),
        strides=(1, 1),
        padding='same'
    )(x)
    x = tf.keras.layers.BatchNormalization()(x)
    x = tf.keras.layers.ReLU()(x)

    return x

def build_mobilenet(input_shape, num_classes, alpha=1.0):
    inputs = tf.keras.Input(shape=input_shape)

    x = tf.keras.layers.Conv2D(32, (3, 3), strides=(2, 2), padding='same')(inputs)
    x = tf.keras.layers.BatchNormalization()(x)
    x = tf.keras.layers.ReLU()(x)

    x = depthwise_separable_conv_block(x, 64, alpha=alpha)
    x = depthwise_separable_conv_block(x, 128, strides=(2, 2), alpha=alpha)
    x = depthwise_separable_conv_block(x, 128, alpha=alpha)
    x = depthwise_separable_conv_block(x, 256, strides=(2, 2), alpha=alpha)
    x = depthwise_separable_conv_block(x, 256, alpha=alpha)
    x = depthwise_separable_conv_block(x, 512, strides=(2, 2), alpha=alpha)

    for _ in range(5):
        x = depthwise_separable_conv_block(x, 512, alpha=alpha)

    x = depthwise_separable_conv_block(x, 1024, strides=(2, 2), alpha=alpha)
    x = depthwise_separable_conv_block(x, 1024, alpha=alpha)

    x = tf.keras.layers.GlobalAveragePooling2D()(x)
    outputs = tf.keras.layers.Dense(num_classes, activation='softmax')(x)

    return tf.keras.Model(inputs, outputs)

def main():
    # 加载 CIFAR-10 数据
    (x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar10.load_data()

    # 归一化 + One-hot 编码
    x_train = x_train.astype('float32') / 255.0
    x_test = x_test.astype('float32') / 255.0
    y_train = tf.keras.utils.to_categorical(y_train, 10)
    y_test = tf.keras.utils.to_categorical(y_test, 10)

    # 构建模型
    model = build_mobilenet(input_shape=(32, 32, 3), num_classes=10, alpha=1.0)
    model.summary()

    # 编译模型
    model.compile(optimizer='adam',
                  loss='categorical_crossentropy',
                  metrics=['accuracy'])

    # 训练模型
    model.fit(x_train, y_train,
              validation_data=(x_test, y_test),
              epochs=10,
              batch_size=64)

    # 测试模型
    test_loss, test_acc = model.evaluate(x_test, y_test, verbose=2)
    print(f'\nTest accuracy: {test_acc:.4f}')

if __name__ == '__main__':
    main()