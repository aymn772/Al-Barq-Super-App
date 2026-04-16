-- SQL Dump for Al-Barq Delivery App
-- Database: albarq_delivery
-- Generated for PHPMyAdmin

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+03:00";

-- --------------------------------------------------------

-- Table structure for table `stores`
CREATE TABLE `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` enum('restaurant','pharmacy','grocery') NOT NULL,
  `image` varchar(500) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `rating` decimal(3,1) DEFAULT 0.0,
  `delivery_time` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `stores`
INSERT INTO `stores` (`name`, `type`, `image`, `address`, `rating`, `delivery_time`, `is_active`) VALUES
('مطاعم الشيباني', 'restaurant', 'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?w=800', 'شارع حدة، صنعاء', 4.9, '30-40 دقيقة', 1),
('فايف ستار برجر', 'restaurant', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', 'شارع المقالح، صنعاء', 4.8, '20-30 دقيقة', 1),
('صيدلية ابن حيان', 'pharmacy', 'https://images.unsplash.com/photo-1586015555751-63bb77f4322a?w=800', 'شارع الزبيري، صنعاء', 4.9, '15-25 دقيقة', 1),
('سوبر ماركت الهدى', 'grocery', 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=800', 'شارع حدة، صنعاء', 4.8, '25-35 دقيقة', 1);

-- --------------------------------------------------------

-- Table structure for table `products`
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `requires_prescription` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`store_id`) REFERENCES `stores`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `products`
INSERT INTO `products` (`store_id`, `name`, `price`, `image`, `description`, `category`, `weight`, `requires_prescription`) VALUES
(1, 'سلتة يمنية', 2500.00, 'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?w=400', 'سلتة يمنية أصلية بالخضار واللحم', 'شعبي', NULL, 0),
(2, 'كلاسيك برجر', 1800.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', 'برجر لحم بقري مشوي مع الجبن', 'برجر', NULL, 0),
(3, 'بنادول أدفانس', 1200.00, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400', 'مسكن للألم وخافض للحرارة', 'أدوية', NULL, 0),
(4, 'طماطم بلدي', 500.00, 'https://images.unsplash.com/photo-1546470427-227c7369a6d1?w=400', 'طازجة من مزارعنا', 'خضروات', '1 كجم', 0);

-- --------------------------------------------------------

-- Table structure for table `orders`
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','preparing','delivering','completed','cancelled') DEFAULT 'pending',
  `prescription_image` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `order_items`
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
